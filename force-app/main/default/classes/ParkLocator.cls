public class ParkLocator {
    public static string[] country(string theCountry) {
        ParkService.ParksImplPort  parkSvc = new ParkService.ParksImplPort();
        return parkSvc.byCountry(theCountry);
    }
}