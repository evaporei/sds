#+build windows
package ito

import win32 "core:sys/windows"

OS_Thread :: struct {
	// order relevant because of padding
	// https://learn.microsoft.com/en-us/cpp/error-messages/compiler-warnings/compiler-warning-level-4-c4820?view=msvc-170
	id:     win32.DWORD,
	handle: win32.HANDLE,
}

wrapper_fn :: proc "stdcall" (arg: win32.LPVOID) -> win32.DWORD {
	context = wrapper_ctx

	data := cast(^Thread_Data)arg
	data.fn(data.arg)
	return 0
}

_os_thread_init :: proc(os_t: ^OS_Thread, data: ^Thread_Data) {
	os_t.handle = win32.CreateThread(nil, 0, wrapper_fn, data, 0, &os_t.id)
	assert(os_t.handle != nil)
}

_os_thread_join :: proc(os_t: ^OS_Thread) {
	win32.WaitForSingleObject(os_t.handle, win32.INFINITE)
	win32.CloseHandle(os_t.handle)
}

_os_thread_detach :: proc(os_t: ^OS_Thread) {
	win32.WaitForSingleObject(os_t.handle, 0)
	win32.CloseHandle(os_t.handle)
}
