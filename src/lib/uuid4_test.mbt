test "format and Uniqueness" {
  let set : @hashset.T[String] = @hashset.new()
  for i in 0..<1000 {
    let uuid = @lib.randomUUID()
    assert_eq!(uuid[14], '4')
    let tmp = uuid[19]
    assert_true!(tmp == '8' || tmp == '9' || tmp == 'a' || tmp == 'b')
    assert_false!(set.contains(uuid))
    set.add(uuid)
  }
}
