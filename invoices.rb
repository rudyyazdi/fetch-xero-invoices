require 'xeroizer'
require 'csv'

# reads this from the CONSUMER_KEY file in the root of the project.
CONSUMER_KEY = IO.read('CONSUMER_KEY').chomp
# no need for customer secret when using rsa
CONSUMER_SECRET = nil

# the time test has been run.
TIME = Time.now

# dates can be either a iso8601 string or nil
START = "2007-01-01T00:00:00"
FINISH = "2008-07-09T00:00:00"

# the columns we want to see in the csv file.
ATTRIBUTES = [
  :contact_name,
  :date,
  :due_date,
  :status,
  :line_amount_types,
  :sub_total,
  :total_tax,
  :total,
  :updated_date_utc,
  :currency_code,
  :fully_paid_on_date,
  :type,
  :invoice_id,
  :invoice_number,
  :amount_due,
  :amount_paid,
  :amount_credited,
  :currency_rate,
  :has_attachments
]

# create params for the query.
arg = {}.tap do |a|
  where = ""
  where += "Date>=DateTime.Parse(\"#{START}\")" if START
  where += "&&" unless where.empty?
  where += "Date<=DateTime.Parse(\"#{FINISH}\")" if FINISH
  a[:where] = where unless where.empty?
end

# Create client (used to communicate with the API).
client = Xeroizer::PrivateApplication.new(CONSUMER_KEY, CONSUMER_SECRET, 'rsa')

results = client.Invoice.all(arg)

CSV.open("results/#{TIME.to_i}.csv", "wb") do |csv|
  csv << ATTRIBUTES
  results.each do |r|
    csv << ATTRIBUTES.map{|a| r.send(a)}
  end
end
