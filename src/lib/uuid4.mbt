extern "js" fn time(num: Int) -> Bytes =
  #|(num) => {
  #|  const crypto = require('crypto');
  #|  const timestamp = (Date.now()+num).toString();
  #|  const hash = crypto.createHash('sha256');
  #|  hash.update(timestamp);
  #|  const hashHex = hash.digest('hex');
  #|  const seed = Buffer.from(hashHex, 'hex');
  #|  return seed;
  #|};

let table = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f']
///|
/// create version 4 UUID conforming to RFC412
pub fn randomUUID() -> String{
  let uuid = "xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx".to_array()
  for i in 0..<uuid.length() {
    let mut randnum = @random.int(@random.new(seed = time(i)), limit = 15)
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