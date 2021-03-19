use std::slice;
use blake2::VarBlake2b;
use blake2::digest::{Update, VariableOutput};

fn to_u8_vec(pointer: *const u8, len: usize) -> Vec<u8> {
	let data_slice = unsafe {
		assert!(!pointer.is_null());
		slice::from_raw_parts(pointer, len)
	};
	data_slice.to_vec()
}

#[no_mangle]
pub extern fn rust_blake2b(p: *const u8, len: usize, out_len: usize) -> *const u8{
	let data = to_u8_vec(p, len);
	let mut hasher = VarBlake2b::new(out_len).unwrap();
	hasher.update(&data);
	let mut result = vec![0u8; out_len];
	hasher.finalize_variable(|res| {
		result.copy_from_slice(res);
	});
	hex::encode(result).as_ptr()
}
