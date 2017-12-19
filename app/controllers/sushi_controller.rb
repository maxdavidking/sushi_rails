class SushiController < ApplicationController
  def index
    @sushi = Sushi.where(user_id: session[:user_id])
  end

  def new
    @sushi = Sushi.new
  end

  def create
    sushi = Sushi.new(sushi_params)
    sushi.save
    redirect_to('/sushi')
  end

  def edit
    @sushi = Sushi.find(params[:id])
  end

  def update
    @sushi = Sushi.find(params[:id])
    if @sushi.update_attributes(sushi_params)
      redirect_to('/sushi')
    else
      render 'edit'
    end
  end

  def test
    @sushi = Sushi.find(params[:id])
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
      logger: Rails.logger,
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
        "sus:Name" => "Blank"
        #"sus:Email" => "#{@options[:password]}"
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
    rescue
      @response = ""
      #@file = File.open("raw_xml/#{@options[:customer]}-#{Time.now.strftime("%Y%m%d")}.xml", "w+")
      #File.write(@file, xml.to_xml)
  end

  def call
    @sushi = Sushi.find(params[:id])
    helpers.sushi_call
    helpers.months_math(@sushi.report_start, @sushi.report_end)
    helpers.count_months
    respond_to do |format|
      format.html
      format.csv { send_data helpers.csv_open, filename: "users-#{Date.today}.csv" }
    end
  end

  def destroy
    @sushi = Sushi.find(params[:id])
    @sushi.destroy
    redirect_to('/sushi')
  end
  def sushi_params
    params.require(:sushi).permit(:name, :endpoint, :cust_id, :req_id, :report_start, :report_end, :password, :user_id)
  end
end
