# fetch Xero invoices

this library helps you create a CSV file from all the invoices in your Xero account.

# setup

You need Ruby installed in your machine to be able to work with the script.

1. clone this repo from GitHub in your local machine.
2. cd into the directory and run `bundle install` to install the dependencies.
3. create a file called `CONSUMER_KEY` and paste your customer key in it.
4. create a file called `rsa` and paste your private key in there.
5. fill in or set the date criteria for your search to `nil`. (ie. `START` & `FINISH` variables)

and finally

6. run `ruby invoices.rb` in your terminal to trigger the script. This will create and put the CSV file inside the results folder with a timestamp attached to it.
