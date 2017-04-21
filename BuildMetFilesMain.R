# BuildMetFilesMain.R
# Author: John Orr
# This is the top-level R script to build the meteorological forcing files for
# the Clear Creek at Golden VIC model.
#
BuildMetFilesMain <- function(getFiles = FALSE) {
        # Downloads and/or builds the meteorological forcing files for the
        # Clear Creek at Golden VIC model if 
        if(getFiles == TRUE) {
                # Read the Clear Creek soil.06719505latandlongonly file
                # for lat and long for the desired .bz2 file from Livneh
                # Research Group
                file_with_path <- paste(getwd(), "/parameters/soil.06719505latandlongonly.txt", sep = "")
                conn <- file(file_with_path)
                linn <- readLines(conn)
                # Construct the download path and download the forcing file by 
                # iterating across the lat and long file. For this project the lat is always
                # length 8 and long is always length 10. .BZ2 files to download are located at
                # ftp://192.12.137.7/pub/dcp/archive/OBS/livneh2014.1_16deg/VIC.ASCII/. Directories
                # start with "latitude.<latitude> and the filename is 
                # Fluxes_Livneh_NAmerExt_15Oct2014_<latitude>_<longitude>.bz2.
                for(i in 1:length(linn)){
                        current_lat_long <- linn[i]
                        current_lat <- substr(current_lat_long, 0, 8) 
                        current_long <- substr(current_lat_long, 10,19)
                        #Build the filename for current_lat and current_long
                        current_file <- paste("ftp://192.12.137.7/pub/dcp/archive/OBS/livneh2014.1_16deg/VIC.ASCII/latitude.",
                                        current_lat, "/Fluxes_Livneh_NAmerExt_15Oct2014_", current_lat, "_",
                                        current_long, ".bz2", sep = "")
                        destfile <- paste("./forcings/", basename(current_file))
                        # Retrieve the file for the current_lat and current_long from the Internet
                        download.file(current_file, destfile)
                }
        }
        else {
                # Just build the forcing files
                print("I am not here!")
        }
        close.connection(conn)
}
        
