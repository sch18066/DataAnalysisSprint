# this loads our dataset into memory
data <- read.csv("road_accident_data.csv", stringsAsFactors = FALSE)

#this filters out some of the lines to just the accidents on public roads
filtered_data <- subset(data, public_road == "True")

#show total row count and then filtered row count to make sure the filter is working
nrow(data)
nrow(filtered_data)


#Question 1: Do more lanes mean more accidents?
# make "lane_stats" and fill it with one row for each lane count
# then add the mean accidents per each lane count

lane_stats <- aggregate(
  num_reported_accidents ~ num_lanes,
  data = filtered_data,
  FUN = mean
)

#make lane_stats_sorted and sort it based on who had the most accidents.
lane_stats_sorted <- lane_stats[order(-lane_stats$num_reported_accidents), ]



#Question 2: What type of road is more prone to accidents?
# similar to before, make a stats page with number of accidents based on each road type

roadtype_stats <- aggregate(
  num_reported_accidents ~ road_type,
  data = filtered_data,
  FUN = mean
)

# and then sort it based on who had the most accidents
roadtype_sorted <- roadtype_stats[order(-roadtype_stats$num_reported_accidents), ]

#output our new data to a csv so we can actually see what we found out
write.csv(lane_stats_sorted, "lane_analysis_results.csv", row.names = FALSE)
write.csv(roadtype_sorted, "roadtype_analysis_results.csv", row.names = FALSE)
