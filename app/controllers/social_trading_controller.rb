class SocialTradingController < ApplicationController

require 'date'

  def index
    #code
    today = Date.today
    date_90days_ago = today - 90
    dt_date_90days_ago = date_90days_ago.to_datetime


    # p today.to_datetime
    # p date_90days_ago

    # Transactions.where(created_at: (Time.now.midnight - 1.day)..Time.now.midnight)

    all_past90days_transactions = Transaction.where(created_at: dt_date_90days_ago..today)

    # all_past90days_transactions.each do |record|
    #   p record
    # end

    txn_count = Transaction.group(:user_id).count
    # p txn_count.values
    #
    sorted = (txn_count.sort_by { |a, b| b}).reverse
    # p sorted

    @active_trader_list = []

    sorted.each do |most_active_trader|
      # print "user name:"
      # p User.find(most_active_trader[0]).name
      # print "number of trades"
      # p most_active_trader[1]
      @active_trader_list.push({
        user_name: User.find(most_active_trader[0]).name,
        user_id: most_active_trader[0],
        trades: most_active_trader[1]
      })


    end

    #p @active_trader_list.inspect

    @active_from = date_90days_ago
    @active_to = today


  end

  def show
    # render html: "show active trader ID: #{params}" #{params[:id]}
    arr = params[:id].split("+")
    # render html: "aaa #{aaa}; bbb #{bbb}"
    @active_trader = User.find(arr[0])
    @trader_ranking = arr[1]

    today = Date.today
    date_90days_ago = today - 90
    dt_date_90days_ago = date_90days_ago.to_datetime

    all_past90days_transactions = Transaction.where(created_at: dt_date_90days_ago..today, user_id: arr[0])

    @all_past90days_transactions = []
    all_past90days_transactions.each do |transaction|
      txn = []
      txn.push(transaction[:txn_type])
      txn.push(transaction[:currency_id])
      txn.push(transaction[:units])
      txn.push('%.2f' %(transaction[:amount_unit]/transaction[:units]))
      txn.push(transaction[:created_at].to_date)
      @all_past90days_transactions.push(txn)
    end

  end


end
