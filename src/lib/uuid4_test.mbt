test "UUID Format and Structure" {
  // Mock seed function that returns constant 32 bytes
  fn mock_seed() -> Bytes {
    @bytes.from_array(Array::make(32,b'0'))
  }
  let uuid = @lib.randomUUID(mock_seed)
  println(uuid)
  
  // Test length
  assert_eq!(uuid.length(), 36)
  
  // Test format pattern (8-4-4-4-12)
  let parts = uuid.split("-").to_array()
  assert_eq!(parts[0].length(), 8)
  assert_eq!(parts[1].length(), 4)
  assert_eq!(parts[2].length(), 4)
  assert_eq!(parts[3].length(), 4)
  assert_eq!(parts[4].length(), 12)
  
  // Test version (should be 4)
  assert_eq!(uuid[14], '4')
  
  // Test variant (should be 8, 9, a, or b)
  let variant = uuid[19]
  assert_true!(variant == '8' || variant == '9' || variant == 'a' || variant == 'b')
}

test "UUID Characters" {
  // Mock seed function that returns constant 32 bytes
  fn mock_seed() -> Bytes {
    @bytes.from_array(Array::make(32,b'0'))
  }
  let uuid = @lib.randomUUID(mock_seed)
  let valid_chars = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', '-']
  
  // Test all characters are valid hexadecimal or hyphen
  for c in uuid {
    assert_true!(valid_chars.contains(c))
  }
}

test "Consistent Output for Same Seed" {
  fn fixed_seed() -> Bytes {
    @bytes.from_array(Array::make(32,b'0'))
  }
  
  let uuid1 = @lib.randomUUID(fixed_seed)
  let uuid2 = @lib.randomUUID(fixed_seed)
  
  // Same seed should produce same UUID
  assert_eq!(uuid1, uuid2)
}