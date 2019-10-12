class APIPath {
  static String user(String uid, String jobId) => 'users/$uid/data/$jobId';
  static String users(String uid) => 'users/$uid/data';
 //static String entry(String uid, String entryId) =>
 //    'users/$uid/entries/$entryId';
 //static String entries(String uid) => 'users/$uid/entries';
}
