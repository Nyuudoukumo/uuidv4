extern "js" fn seed() -> Bytes =
  #|() => {
  #|  const crypto = require('crypto');
  #|  const timestamp = (Date.now()).toString();
  #|  const hash = crypto.createHash('sha256');
  #|  hash.update(timestamp);
  #|  const hashHex = hash.digest('hex');
  #|  const seed = Buffer.from(hashHex, 'hex');
  #|  return seed;
  #|};

test "Uniqueness" {
  let set : @hashset.T[String] = @hashset.new()
  for i in 0..<10000 {
    let uuid = @lib.randomUUID(seed)
    assert_false!(set.contains(uuid))
    set.add(uuid)
  }
  assert_eq!(set.size(), 10000)
}
