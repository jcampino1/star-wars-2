Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "consultas#index"
  get "consulta_especifica", to: "consultas#consulta_especifica", as: :consulta_especifica
  get "persona", to: "consultas#persona", as: :persona
  get "planeta", to: "consultas#planeta", as: :planeta
  get "nave", to: "consultas#nave", as: :nave

end
