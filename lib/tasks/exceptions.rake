namespace :exceptions do
  task :list => :environment do
    exceptions = []

    ObjectSpace.each_object(Class) do |k|
      exceptions << k if k.ancestors.include?(Exception)
    end

    puts exceptions.sort { |a,b| a.name <=> b.name }.join("\n")
  end
end