local func = require("config.functions")

-- Options snippet
func.rust.wrap('o', 'Option<', '>', "WORD to [O]ption<WORD>")
func.rust.wrap('s', 'Some(', ')', "WORD to [S]ome(WORD)")
func.rust.wrap('O', 'Ok(', ')', "WORD to [O]k(WORD)")
