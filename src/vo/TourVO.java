package vo;

public class TourVO {

   int tseq;
   String location;
   String theme_m;
   String theme_s;
   String name;
   String detail;
   String link;
   String address;
   String image;
   String x;
   String y;
   
   public int getTseq() {
      return tseq;
   }
   public void setTseq(int tseq) {
      this.tseq = tseq;
   }
   public String getLocation() {
      return location;
   }
   public void setLocation(String location) {
      this.location = location;
   }
   public String getTheme_m() {
      return theme_m;
   }
   public void setTheme_m(String theme_m) {
      this.theme_m = theme_m;
   }
   public String getTheme_s() {
      return theme_s;
   }
   public void setTheme_s(String theme_s) {
      this.theme_s = theme_s;
   }
   public String getName() {
      return name;
   }
   public void setName(String name) {
      this.name = name;
   }
   public String getDetail() {
      return detail;
   }
   public void setDetail(String detail) {
      this.detail = detail;
   }
   public String getLink() {
      return link;
   }
   public void setLink(String link) {
      this.link = link;
   }
   public String getAddress() {
      return address;
   }
   public void setAddress(String address) {
      this.address = address;
   }
   public String getImage() {
      return image;
   }
   public void setImage(String image) {
      this.image = image;
   }
   public String getX() {
      return x;
   }
   public void setX(String x) {
      this.x = x;
   }
   public String getY() {
      return y;
   }
   public void setY(String y) {
      this.y = y;
   }
   @Override
   public String toString() {
      return "TourVO [tseq=" + tseq + ", location=" + location + ", theme_m=" + theme_m + ", theme_s=" + theme_s
            + ", name=" + name + ", detail=" + detail + ", link=" + link + ", address=" + address + ", image="
            + image + ", x=" + x + ", y=" + y + "]";
   }
   
}