//go:build !amd64

package gopic

import "runtime"

// procyield stanowi zastępczą implementację dla architektur innych niż amd64,
// przekazującą sterowanie planiście Go za pomocą runtime.Gosched.
//
// Parametry:
//   - cycles: nieużywany parametr liczby cykli zachowany dla zgodności sygnatury.
func procyield(cycles uint32) {
	runtime.Gosched()
}
