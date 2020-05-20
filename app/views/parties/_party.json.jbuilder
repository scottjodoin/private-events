json.extract! party, :id, :belongs_to, :location, :start_time, :end_time, :details, :created_at, :updated_at
json.url party_url(party, format: :json)
