QueryRoot = GraphQL::ObjectType.define do
  name 'Query'
  description '...'

  field :group do
    type GroupType
    argument :id, !types.ID
    resolve -> (root, args, ctx) {
      group = Group.find(args[:id])
      ctx[:pundit].authorize group, :show?

      group
    }
  end
end

Schema = GraphQL::Schema.define do
  query QueryRoot
end
