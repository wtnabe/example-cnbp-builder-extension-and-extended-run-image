require 'sinatra'
require_relative '../lib/store'
require_relative './store_document'

db = Store.init((ENV['DB_ENGINE'] || :gdbm).to_sym)

get '/:id' do
  doc = db[params[:id]]

  if doc
    content_type :json
    { content: doc }.to_json + "\n"
  else
    halt 404
  end  
end

post '/:id' do
  result = StoreDocument.call(db: db, id: params[:id], body: request.body)

  if result.success?
    [201, "Created\n"]
  else
    [400, result.error]
  end
end
