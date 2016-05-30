class LandmarksController < Sinatra::Base
      set :views, Proc.new { File.join(root, "../views/") }
      
    get "/landmarks/new" do
        erb :"landmarks/new"
    end
    
    get "/landmarks/:id/edit" do
        @landmark = Landmark.find(params[:id])
        erb :"landmarks/edit"
    end
    
    get "/landmarks" do
        @list = Landmark.all
        erb :'landmarks/index'
    end
    
    get "/landmarks/:id" do
        @landmark = Landmark.find(params[:id])
        erb :"landmarks/show"
    end
    
    post "/landmarks" do
        puts params
        @landmark = Landmark.create(name: params[:landmark_name])
        @landmark.year_completed = params[:landmark_year_completed]
        @landmark.save
        params.to_s
    end
    
    patch "/landmarks" do
        puts params
        @landmark = Landmark.find(params[:landmark][:id])
        @landmark.name = params[:landmark][:name]
        @landmark.year_completed = params[:landmark][:year_completed]
        @landmark.save
        redirect to "/landmarks/#{@landmark.id}"
    end

end
