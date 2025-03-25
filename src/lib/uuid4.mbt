let table = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
///|
/// create version 4 UUID conforming to RFC412
/// ## Parameters
/// - `get_seed` : A function that returns a 32-byte seed.   
///   The seed function should:  
///   - Always return exactly 32 bytes
///   - Ensure uniqueness across rapid consecutive calls
/// ## Example
/// ```
/// extern "js" fn seed() -> Bytes =
///   #|() => {
///   #|  const crypto = require('crypto');
///   #|  const timestamp = (Date.now()).toString();
///   #|  const hash = crypto.createHash('sha256');
///   #|  hash.update(timestamp);
///   #|  const hashHex = hash.digest('hex');
///   #|  const seed = Buffer.from(hashHex, 'hex');
///   #|  return seed;
///   #|};
///
/// test "format and Uniqueness" {
///   let set : @hashset.T[String] = @hashset.new()
///   for i in 0..<1000 {
///     let uuid = @lib.randomUUID(seed)
///     println(uuid)
///     assert_eq!(uuid[14], '4')
///     let tmp = uuid[19]
///     assert_true!(tmp == '8' || tmp == '9' || tmp == 'a' || tmp == 'b')
///     assert_false!(set.contains(uuid))
///     set.add(uuid)
///   }
/// }
/// ```
pub fn randomUUID(get_seed: () -> Bytes) -> String{
  if get_seed().length() != 32 {
    abort("seed must be 32 bytes long")
  }
  let uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".to_array()
  for i in 0..<uuid.length() {
    let seed = @bytes.from_iter(get_seed()
      .to_array()
      .map(fn(x) {x + i.to_byte()})
      .iter()
    )
    let mut randnum = @random.int(@random.new(seed = seed), limit = 15)
    match uuid[i] {
      'x' => uuid[i] = table[randnum]
      'y' => {
          // set variant conforming to RFC4122
          randnum = randnum & 0b0011 | 0b1000
          uuid[i] = table[randnum]
        }
      _ => ()
    }
  }
  String::from_array(uuid)
}