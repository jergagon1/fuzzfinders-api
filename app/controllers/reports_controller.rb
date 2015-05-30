class ReportsController < ApplicationController
  def mapquery
    #Example map query http://localhost:3001/reports/mapquery?sw=37.70186970040842,-122.16973099925843&ne=37.70764178721548,-122.15589080074159
    swa = params[:sw].split(',').map(&:to_f)
    nea = params[:ne].split(',').map(&:to_f)
    sw = Geokit::LatLng.new(swa.first, swa.last)  #Make the SW as a point instance in Geokit
    ne = Geokit::LatLng.new(nea.first, nea.last)  #Make the NE as a point instance in Geokit
    reports_within_map = Report.in_bounds([sw, ne]) #Get all Report instances from the database
    reports_hash = { type: "FeatureCollection", features: Array.new } #Packaging the Report into GeoJSON format
    reports_within_map.each do |report|
      column_values = Hash.new # for storing all Report data in the hash
      Report.column_names.each{|name| column_values[name.to_sym] = report.send(name) unless report.send(name).nil? }  #This iterate all values of a report and put into the hash
      reports_hash[:features] << { type: "Feature", geometry: { type: "Point", coordinates: [report.lng, report.lat] }, properties: column_values }   #put all Report data into properties of GeoJSON
    end
    render json: reports_hash
  end
end
