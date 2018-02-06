module ApplicationHelper
  attr_reader :error

  def sushi_call
    begin
    #Set up client for connection
    client = Savon.client(
    wsdl: "http://www.niso.org/schemas/sushi/counter_sushi4_0.wsdl",
    endpoint: @sushi.endpoint,
    #Possible namespaces required by WSDL
    namespaces:{
      "xmlns:tns" => "SushiService",
      "xmlns:sc" => "http://www.niso.org/schemas/sushi/counter",
      "xmlns:xsd" => "http://www.w3.org/2001/XMLSchema",
      "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
      "xmlns:sus" => "http://www.niso.org/schemas/sushi",
      "xmlns:soap" => "http://schemas.xmlsoap.org/wsdl/soap",
      "xmlns:soap12" => "http://schemas.xmlsoap.org/wsdl/soap12/"
      },
      convert_request_keys_to: :none,
      #Log default is false, unless specified by user
      logger: Logger.new('log/savon.log', 10, 1024000),
      log: true,
      log_level: :debug,
      #Pretty Print is dependent on logging being on
      pretty_print_xml: true,
      env_namespace: :soapenv
    )
      #Send out call for data, passing all parameters for login/data
    @response = client.call(:get_report, message: {
      "sus:Requestor" => {
        "sus:ID" => @sushi.req_id,
        "sus:Name" => "Blank",
        "sus:Email" => @sushi.password
      },
      "sus:CustomerReference" => {
        "sus:ID" => @sushi.cust_id
      },
      "sus:ReportDefinition" => {
        "sus:Filters" => {
            "sus:UsageDateRange" => {
            "sus:Begin" => @sushi.report_start,
            "sus:End" => @sushi.report_end
            },
          },
        },
        :attributes! => {
          "sus:ReportDefinition" => {
            "Release" => "4",
            "Name" => "JR1"
          },
        },
      } )
    rescue StandardError => error
      @error = error
      @response = ""
    end
  end

  def months_math(date1, date2)
    date1parsed = Date.parse(date1)
    date2parsed = Date.parse(date2)
    @month_array = []
    m = (date2parsed.year * 12 + date2parsed.month) - (date1parsed.year * 12 + date1parsed.month) + 1
    @months_var = m
    m.times do |n|
      iterator = date1parsed >> n
      @month_array << iterator.to_s
    end
  end

  def count_months
    @count_var = @months_var - 1
  end

  def xml_open
    @noko_doc = @response.doc
    @noko_doc.remove_namespaces!
  end

  def get_secondary_data
    @doc_requestor = @noko_doc.xpath('//Requestor/ID').text
    @doc_customer_ref = @noko_doc.xpath('//CustomerReference/ID').text
    @doc_release = @noko_doc.xpath('//ReportDefinition').attr('Release').text
    @doc_version = @noko_doc.xpath('//ReportDefinition').attr('Name').text
  end

  def get_item_data
    count_hash = Hash[@month_array.map{|x| [x.to_sym] }]
    @report_data = []
    @total_stats = []
    @html_data = []
    @pdf_data = []
    @usage_data = []
    @month_holder = []
    x = 0

    #Store all months from XML data into an array to match later against Hash
    @noko_doc.xpath('//ReportItems').each do |item|

      item.xpath("./ItemPerformance/Period").each do |match|
        matches = match.xpath("./Begin").text
        @month_holder << matches
      end

      #Reset hash values so they don't carry over from previous item
      count_hash.each {|k, v| count_hash[k] = "0"}
      item.xpath("./ItemPerformance/Instance[MetricType = 'ft_total']").each do |count|
        month = count.xpath("../Period/Begin").text
        counts = count.xpath("./Count").text
          if counts.empty?
            counts = "0"
          else counts = counts
          end
          count_hash[month.to_sym] = counts
        end

      #Match months supplied by user to months in month_holder array
      #and grab usage stats for those months
      n = 0
      @months_var.times do
        if @month_holder.include? @month_array[n]
          month_key = @month_array[n]
          count = count_hash[month_key.to_sym]
          @total_stats << count
          if n < @count_var
            n += 1
          else n = 0
          end
        else
          fallback_count = "0"
          @total_stats << fallback_count
          if n < @count_var
            n += 1
          else n = 0
          end
        end
      end

      doi = item.xpath("./ItemIdentifier[Type = 'DOI']/Value").text
      value = item.xpath("./ItemIdentifier[Type = 'Proprietary']/Value").text
      print_issn = item.xpath("./ItemIdentifier[Type = 'Print_ISSN']/Value").text
      online_issn = item.xpath("./ItemIdentifier[Type = 'Online_ISSN']/Value").text
      platform = item.xpath("./ItemPlatform").text
      publisher = item.xpath("./ItemPublisher").text
      name = item.xpath("./ItemName").text

      #Empty html_stats array as not all reports return the same number of months
      html_stats = []
      item.xpath("./ItemPerformance/Instance[MetricType = 'ft_html']").each do |month|
        count_html = month.xpath("./Count").text
        html_stats << count_html
        @html_data << count_html
      end

      #Empty pdf_stats array as not all reports return the same number of months
      pdf_stats = []
      item.xpath("./ItemPerformance/Instance[MetricType = 'ft_pdf']").each do |month|
        count_pdf = month.xpath("./Count").text
        pdf_stats << count_pdf
        @pdf_data << count_pdf
      end

      #Get all "total" stats into array as not all pdf_stats and html_stats add up to "total"
      item.xpath("./ItemPerformance/Instance[MetricType = 'ft_total']").each do |month|
        count_total = month.xpath("./Count").text
        @usage_data << count_total
      end

      #Reset pdf_iterator and html_iterator
      @pdf_iterator = 0
      @html_iterator = 0
      #Make code below DRYer
      @total_stats.each_slice(@months_var).each do |slice|
        @iterator = slice.map(&:to_i)
      end
      html_stats.each_slice(@months_var).each do |slice|
        html_integer = slice.map(&:to_i)
        @html_iterator = html_integer.reduce(0, :+)
      end
      pdf_stats.each_slice(@months_var).each do |slice|
        pdf_integer = slice.map(&:to_i)
        @pdf_iterator = pdf_integer.reduce(0, :+)
      end
      @item_total = @pdf_iterator + @html_iterator
      #store data in array below to output to specified file type
      @report_data << [name, publisher, platform, doi, value, print_issn, online_issn, @item_total, @html_iterator, @pdf_iterator, @iterator]
      @report_data[x].flatten!
      x += 1
    end
  end

  def get_total_data
    month_stats = []

    @months_var.times do
      all_stats = @total_stats.select.with_index {|x, index| index % @months_var == 0 }
      month_stats << all_stats.map(&:to_i).reduce(:+)
      @total_stats.shift
    end

    @monthly_total = month_stats.map(&:to_i)
    @total_pdf = @pdf_data.map(&:to_i).reduce(0, :+)
    @total_html = @html_data.map(&:to_i).reduce(0, :+)
    @total_usage = @usage_data.map(&:to_i).reduce(0, :+)
  end

  def data_write(separator)
    CSV.generate(:col_sep => separator) do |row|
      row << ["#{@doc_version}", "Release: #{@doc_release}"]
      row << ["Requestor ID: #{@doc_requestor}", " Customer ID: #{@doc_customer_ref}"]
      row << ["Period covered by Report:"]
      row << ["#{@sushi.report_start} to #{@sushi.report_end}"]
      row << ["Date run:"]
      row << ["#{Time.now.strftime("%d/%m/%Y")}"]
      row << ["Journal", "Publisher", "Platform", "Journal DOI", "Proprietary Identifier", "Print ISSN", "Online ISSN", "Reporting Period Total", "Reporting Period HTML", "Reporting Period PDF", @month_array].flatten!
      row << ["Total for all Journals", "", @platform, "","","","", @total_usage, @total_html, @total_pdf, @monthly_total].flatten!
      #Iterates through array, printing each item to a row
      @report_data.each do |data|
        row << data
      end
    end
  end
end
