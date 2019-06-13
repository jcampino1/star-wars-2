require "graphql/client"
require "graphql/client/http"

class ConsultasController < ApplicationController

	# Star Wars API example wrapper
	module SWAPI
	  # Configure GraphQL endpoint using the basic HTTP network adapter.
	  HTTP = GraphQL::Client::HTTP.new("https://swapi-graphql-integracion-t3.herokuapp.com/")
	  
	  # Fetch latest schema on init, this will make a network request
	  Schema = GraphQL::Client.load_schema(HTTP)

	  Client = GraphQL::Client.new(schema: Schema, execute: HTTP)

	end

	AllFilmsQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query {
       allFilms {
       	films {
       	 id
         title
         releaseDate
         director
         producers
         episodeID
       	}
       }
  	  }
	GRAPHQL

	def index
		@result = SWAPI::Client.query(AllFilmsQuery)
	end

	FilmQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	film(id: $id) {
	   	 id
	     title
	     releaseDate
	     director
	     producers
	     episodeID
	     characterConnection{
	     	characters{
	     		id
	     		name
	     	}
	     }
	     starshipConnection{
	     	starships{
	     		id
	     		name
	     	}
	     }
	     planetConnection{
	     	planets{
	     		id
	     		name
	     	}
	     }
	   	}
  	  }
	GRAPHQL

	def consulta_especifica
		# Pelicula
		@result = SWAPI::Client.query(FilmQuery, variables: { id: params[:id]})
	end

	PersonQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	person(id: $id) {
	   	 id
	     name
	     birthYear
	     eyeColor
	     gender
	     hairColor
	     height
	     mass
	     skinColor
	     homeworld{
	     	name
	     	id
	     }
	     filmConnection{
	     	films{
	     		id
	     		title
	     	}
	     }
	     starshipConnection{
	     	starships{
	     		id
	     		name
	     	}
	     }
	   	}
  	  }
	GRAPHQL

	def persona
		@result = SWAPI::Client.query(PersonQuery, variables: { id: params[:id]})
	end

	PlanetQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	planet(id: $id) {
	   	 id
	     name
	     diameter
	     rotationPeriod
	     orbitalPeriod
	     gravity
	     population
	     climates
	     terrains
	     surfaceWater
	     filmConnection{
	     	films{
	     		id
	     		title
	     	}
	     }
	     residentConnection{
	     	residents{
	     		id
	     		name
	     	}
	     }
	   	}
  	  }
	GRAPHQL

	def planeta
		@result = SWAPI::Client.query(PlanetQuery, variables: { id: params[:id]})
	end

	StarshipQuery = SWAPI::Client.parse <<-'GRAPHQL'
	  query($id: ID!) {
	   	starship(id: $id) {
	   		name
	   		model
	   		starshipClass
	   		manufacturers
	   		costInCredits
	   		length
	   		crew
	   		passengers
	   		maxAtmospheringSpeed
	   		hyperdriveRating
	   		MGLT
	   		cargoCapacity
	   		consumables
	   		pilotConnection{
	   			pilots{
	   				name
	   				id
	   			}
	   		}
	   		filmConnection{
	   			films{
	   				id
	   				title
	   			}
	   		}
	   	}
	   }
	GRAPHQL

	def nave
		@result = SWAPI::Client.query(StarshipQuery, variables: { id: params[:id]})
	end
end
