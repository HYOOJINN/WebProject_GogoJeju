package vo;

public class ReviewVO {

   String id;
   int tseq;
   int rseq;
   String review;
   @Override
   public String toString() {
      return "ReviewVO [id=" + id + ", tseq=" + tseq + ", rseq=" + rseq + ", review=" + review + "]";
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public int getTseq() {
      return tseq;
   }
   public void setTseq(int tseq) {
      this.tseq = tseq;
   }
   public int getRseq() {
      return rseq;
   }
   public void setRseq(int rseq) {
      this.rseq = rseq;
   }
   public String getReview() {
      return review;
   }
   public void setReview(String review) {
      this.review = review;
   }
}