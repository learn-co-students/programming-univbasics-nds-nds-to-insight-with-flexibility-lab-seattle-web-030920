# Provided, don't edit
require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2],
# [3,4,5], [6]] => [1,2,3,4,5,6].

def flatten_a_o_a(aoa)
  result = []
  i = 0

  while i < aoa.length do
    k = 0
    while k < aoa[i].length do
      result << aoa[i][k]
      k += 1
    end
    i += 1
  end

  result
end

def movie_with_director_name(director_name, movie_data)
  { 
    :title => movie_data[:title],
    :worldwide_gross => movie_data[:worldwide_gross],
    :release_year => movie_data[:release_year],
    :studio => movie_data[:studio],
    :director_name => director_name
  }
end


# Your code after this point

def movies_with_director_key(name, movies_collection)
  movies_with_director_key_array = []
  movie_index = 0 
  
  while movie_index < movies_collection.length do
    movies_with_director_key_array << movie_with_director_name(name, movies_collection[movie_index])
    movie_index += 1 
  end
  movies_with_director_key_array
end

def find_gross_by_director_and_title (director, title, repeated_title_index)
  a = 0 
  retrieved = []
  
  #Looking for #{director} and #{title} in directors_database    
  while a < directors_database.length do
    if directors_database[a][:name] == director
      b = 0  
      found = false
      
      while b < directors_database[a][:movies].length && !found do
        if directors_database[a][:movies][b][:title] == title 
          if repeated_title_index == 1 
            b += 1 
          end
          
          retrieved << directors_database[a][:movies][b][:studio]
          retrieved << directors_database[a][:movies][b][:worldwide_gross]
          found = true
        end
        b += 1
      end
    end          
    a += 1
  end
  retrieved 
end

def gross_per_studio(collection)
  
  studio_index = 0 
  studio_gross_hash = {}

  while studio_index < collection.length do
    gross = 0 
    
    #if given director+title
    if !collection[studio_index][:studio] || !collection[studio_index][:worldwide_gross]

      #is this title repeated in collection?
      verify_index = 0
      repeated_title = 0 
      
      while verify_index < studio_index
        if collection[verify_index][:title] == collection[studio_index][:title]
          pp "Found #{collection[studio_index][:title]} repeated."
          repeated_title = 1 
        end
        verify_index += 1 
      end
      
      director = collection[studio_index][:director_name]
      title = collection[studio_index][:title]
      
      studio_name = find_gross_by_director_and_title(director, title, repeated_title)[0]
      gross = find_gross_by_director_and_title(director, title, repeated_title)[1]

    #else given studio + gross
    else
      studio_name = collection[studio_index][:studio]
      gross = collection[studio_index][:worldwide_gross]
    end

    if !studio_gross_hash[studio_name]
      studio_gross_hash[studio_name] = gross
    else
      studio_gross_hash[studio_name] += gross
    end

    studio_index += 1 
  end 
  
  studio_gross_hash
end

def movies_with_directors_set(source)
  director_index = 0 
  return_array = []
  
  while director_index < source.length do 
    director = source[director_index][:name]
    film_index = 0 
    
    while film_index < source[director_index][:movies].length do
      film_title = source[director_index][:movies][film_index][:title]
      return_array << [{:title => film_title, :director_name => director}]
      film_index += 1 
    end
    director_index += 1 
  end
  
  return_array
end

# ----------------    End of Your Code Region --------------------
# Don't edit the following code! Make the methods above work with this method
# call code. You'll have to "see-saw" to get this to work!

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
