class API::GraphqlController < ApplicationController
  def query
    variables = params[:variables]
    variables = JSON.parse(variables) if variables && variables.is_a?(String)
    context = { current_user: current_user, pundit: self }
    result_hash = Schema.execute(params[:query], variables: variables,
                                                 context: context)

    render json: result_hash, callback: params[:callback]
  end
end
