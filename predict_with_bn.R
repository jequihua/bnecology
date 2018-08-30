# load packages
library("bnlearn")
library("gRain")
library("raster")

# load misc functions
source("misc_functions.R")

# prediction
prediction = predict(prior,
                     response="ghf_co_disc",
                     newdata=bnbrik_df,
                     type="distribution")


final_raster = data.frame(prediction,x=brik_df$x,y=brik_df$y)
coordinates(final_raster)=~x+y
gridded(final_raster)=TRUE
final_raster = raster(final_raster)
projection(final_raster)=projection(brik)

# save raster
rf <- writeRaster(final_raster, filename="./datos/prediction_v2.tif",
                  format="GTiff", overwrite=TRUE)