module KgDbFetcher
  
  
  def self.execute(*string_queries)
    ActiveRecord::Base.transaction do
      string_queries.each do |query|
        ActiveRecord::Base.connection.execute(query)
      end
    end
  end
  
  def self.fetch(args)
    connection = ActiveRecord::Base.connection
    if args.respond_to? :upcase # duck type for string
      return connection.execute(args).to_a
    else
      connection = args.fetch(:connection, ActiveRecord::Base.connection)
      query = args.fetch(:query)
      single_result = args.fetch(:single_result, false)
      if single_result # return single result if passed as argument. Otherwise, return an array
        return connection.execute(query).first.values.first
      else
        return connection.execute(query).to_a
      end
    end
  end
  
  def self.fetch_symbolize_keys(args)
    result = KgDbFetcher.fetch(args)
    return result.respond_to?(:each) ? result.map{|line|line.symbolize_keys} : result
  end
  
  def self.fetch_single(query)
    KgDbFetcher.fetch(:query => query, :single_result => true)
  end
  

  def self.reset_pk_sequences
    [
      TrAgency, TrContactInformation, TrDropOffType, TrMatrixStopDistance, TrPathStopSequence,
      TrPickupType, TrRoute, TrRoutePath, TrRoutePathTransferDistance, TrRouteType, TrService, TrServiceDate, TrStation,
      TrShape, TrShelter, TrStop, TrStopTime, TrTerritory, TrTrip, User
    ].each do |data_class|
      data_class.send(:reset_pk_sequence)
    end
  end
  
end
