class FiguresController < Sinatra::Base
    set :views, Proc.new { File.join(root, "../views/") }

    get "/figures/new" do
        @titles = Title.all
        @landmarks = Landmark.all
        erb :'figures/new'
    end
    
    get "/figures/:id/edit" do
        @figure = Figure.find(params[:id])
        @titles = Title.all
        @landmarks = Landmark.all
        erb :'figures/edit'
    end
    
    patch "/figures" do
        puts params
        @figure = Figure.find(params[:figure][:id])
        @figure.name = params[:figure][:name]
        params[:figure][:landmark_ids].each {|x| @figure.landmarks << Landmark.find(x)} unless params[:figure][:landmark_ids].nil?
        params[:figure][:title_ids].each {|x| @figure.titles << Title.find(x)} unless params[:figure][:title_ids].nil?
        @figure.titles << Title.create(name: params[:new_title]) unless params[:new_title].nil?
        @figure.landmarks << Landmark.create(name: params[:new_landmark]) unless params[:new_landmark].nil?
        @figure.save
        redirect to "/figures/#{@figure.id}"
        #"How about a nice patch request?"
    end
   
    get "/figures/:id" do
        @item = Figure.find(params[:id])
        erb :"figures/show"
    end
    

    
    get "/figures" do
        @list = Figure.all
        erb :'figures/index'
    end
    
    post "/figures" do
        puts params
        @figure = Figure.create(name: params[:figure][:name])
        params[:figure][:landmark_ids].each {|x| @figure.landmarks << Landmark.find(x)} unless params[:figure][:landmark_ids].nil?
        params[:figure][:title_ids].each {|x| @figure.titles << Title.find(x)} unless params[:figure][:title_ids].nil?
        @figure.titles << Title.create(name: params[:new_title]) unless params[:new_title].nil?
        @figure.landmarks << Landmark.create(name: params[:new_landmark]) unless params[:new_landmark].nil?
        @figure.save
        params.to_s
    end


end


