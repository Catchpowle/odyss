GroupType = GraphQL::ObjectType.define do
  name 'Group'
  description '...'

  field :id, !types.ID
  field :name, !types.String
  field :objective, !types.String
  field :limit, !types.Int
  field :start_date, !types.String
  field :discord_id, !types.ID
end
