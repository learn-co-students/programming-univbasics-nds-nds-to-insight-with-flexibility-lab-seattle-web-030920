require 'directors_database'

# A method we're giving you. This "flattens"  Arrays of Arrays so: [[1,2], [3,4,5], [6]] => [1,2,3,4,5,6].

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
  new_array=[]
  i=0
  while i<movies_collection.length
    new_array[i]=movie_with_director_name(name, movies_collection[i])
    i+=1
  end
  new_array
end

def gross_per_studio(collection)
  new_hash={}
  i=0
  while i<collection.length
    if new_hash.key?(collection[i][:studio])
      new_hash[collection[i][:studio]]+=collection[i][:worldwide_gross]
    else
      new_hash[collection[i][:studio]]=collection[i][:worldwide_gross]
    end
    i+=1
  end
  new_hash
end

def movies_with_directors_set(source)
  # GOAL: For each director, find their :movies Array and stick it in a new Array
  # INPUT:
  # * source: An Array of Hashes containing director information including
  # :name and :movies
  # RETURN:
  # Array of Arrays containing all of a director's movies. Each movie will need
  # to have a :director_name key added to it.
  
  newarr=[]
  i=0
  while i<source.length
    name=source[i][:name]
    newarr<< movies_with_director_key(name,source[i][:movies])
  i+=1
  end
  newarr
end

def studios_totals(nds)
  a_o_a_movies_with_director_names = movies_with_directors_set(nds)
  movies_with_director_names = flatten_a_o_a(a_o_a_movies_with_director_names)
  return gross_per_studio(movies_with_director_names)
end
