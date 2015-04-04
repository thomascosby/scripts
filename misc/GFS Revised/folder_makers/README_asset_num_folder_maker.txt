
The asset_num_folder_maker script creates new numbered folders in all existing asset 
Raster folders. This script has been updated to reflect GFS 1.0 .

The script prompts you to provide a new folder number (e.g. 6100). It validates 
that you've entered a four digit number ending with two zeros. It then checks 
(arbitrarily) to see if a numbered asset folder with this name already exist in 
/mn_raid1/genmills/PCBU3007/Images/Baking/Raster/. If it finds such a folder, it assumes 
this number is already in use in ALL clients (since we add these numbers to all client 
Raster folders at the same time) and it bails.

If a duplicate folder wasn't found in General Mills, the script creates the numbered 
folder in every Images folder of every client, finishing up by setting the appropriate 
ownership and permissions.

Dan Berks
Jun 6, 2014

