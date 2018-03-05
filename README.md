This project is licensed under the terms of the GNU public license

FetchCounter is a website that lets you store your SUSHI connection information and quickly fetch COUNTER reports.

What type of COUNTER reports does FetchCounter support?
JR1. Hopefully we'll be able to add BR2 and DB1 shortly.

Where do I get SUSHI connection information like my Customer ID and Requestor ID?
Each vendor is different and lists their connection information in different places. In general, you can get this information from your vendor's admin platfrom in the COUNTER tab, or by emailing your vendor rep.

Why aren't my COUNTER requests working?
It depends. My general troubleshooting advice is to read the error message closely and double check your connection information. If your COUNTER request times out, there's a good chance the vendor's server is not responding at this moment and you can just try again in a few hours. For any other issues, please contact me directly at the email listed below.

Why do my test connections work, but when I download a CSV or TSV they don't have any data?
Your Customer ID or your Requestor ID are incorrect. Double check that they match the information supplied by your vendor.

What about COUNTER Release 5?
Release 5 will become mandatory in 2019. There will be many changes to both COUNTER and SUSHI in Release 5, but getting data from SUSHI connections should actually become much easier. I'm hopeful that this site will actually be more useful shortly after Release 5, but that will not be until at least the Spring of 2019. See here for a webinar with more information on Release 5.

Contact
mking9[@]iit.edu

To Do:
- Clear 'test' page cache so it doesn't show false positives or negatives
- Fix 'get' popup styling
- Get Sidekiq background worker to run for 'get' requests
- Store list of downloads for each user
- Allow instance date updates to Active Record through dropdown
- Connect user profiles through an organization model
- Rework front end with React
