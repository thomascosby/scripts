#!
# copy jobs from client (non-GM) Archive Staging to client Archive
#
# Dan B - 7.12.12
#
echo "This script will copy jobs from all client WIP/Archive Staging folders (except for Gen Mills) to the appropriate 2012 Archive Staging folder."
echo
read -p "Are you sure you wish to proceed? (y/n) " -n 1 -r
if [[ $REPLY =~ ^[Yy]$ ]]
then
echo "User confirmed"
cp -rp /r2/3mjobs/3M\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/3marchive/Jobs Archive/2012/
cp -rp /r2/audiovoxjobs/Audiovox\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/audiovoxarchive/Jobs\Archive/2012/
cp -rp /r2/bestbuyjobs/Best\ Buy\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/bestbuyarchive/Jobs\Archive/2012/
cp -rp /r2/centralgardenjobs/Central\ Garden\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/centralgardenarchive/Jobs\ Archive/2012/
cp -rp /r2/conagrajobs/Con\ Agra\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/conagraarchive/Jobs\Archive/2012/
cp -rp /r2/dialjobs/Dial\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/dialarchive/Jobs\ Archive/2012/
cp -rp /r2/diamondfoodsjobs/Diamond\ Foods\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/diamondfoodsarchive/Jobs\ Archive/2012/
cp -rp /r2/dollargeneraljobs/Dollar\ General\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/dollargeneralarchive/Jobs\ Archive/2012/
cp -rp /r2/familydollarjobs/Family\ Dollar\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/familydollararchive/Jobs\ Archive/2012/
cp -rp /r2/faribaultfoodsjobs/Faribault\ Foods\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/faribaultfoodsarchive/Jobs\ Archive/2012/
cp -rp /r2/ghbjobs/GHB\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/ghbarchive/Jobs\ Archive/2012/
cp -rp /r2/hormeljobs/Hormel\ Jobs\ WIP/Archive\ Staging/* /s1/jobsarchive/hormelarchive/Jobs\ Archive/2012/
cp -rp /r2/merckjobs/Merck\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/merckarchive/Jobs\ Archive/2012/
cp -rp /r2/nestlejobs/Nestle\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/nestlearchive/Jobs\ Archive/2012/
cp -rp /r2/otherclientsjobs/Other\ Clients\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/otherclientsarchive/Jobs\ Archive/2012/
cp -rp /r2/pulmuonejobs/Pulmuone\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/pulmuonearchive/Jobs\ Archive/2012/
cp -rp /r2/safewayjobs/Safeway\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/safewayarchive/Jobs\ Archive/2012/
cp -rp /r2/unileverjobs/Unilever\ Jobs\ WIP/Archive\ Staging/* /s2/jobsarchive/unileverarchive/Jobs\ Archive/2012/
else
    echo "Cancelled"
fi
