require 'interactor'

class StoreDocument
  include Interactor

  def call
    if context.id =~ /\A[0-9a-zA-Z]+\z/
      context.db[context.id] = context.body.to_s
    else
      context.fail!(error: "id #{id} is not valid")
    end
  end
end
