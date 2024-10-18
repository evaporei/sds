package sds_demo

import sds ".."
import "core:fmt"

main :: proc() {
    // This stupid "coverage test" exists just to force the compiler to compile every procedure,
    // because polymorphic procs get instantiated and checked only when used.
    // Otherwise it's easy to miss dumb compile errors and typos.
    {
        ds: sds.Array(8, f32)
        sds.array_append(&ds, 123.0)
        sds.array_append_elems(&ds, 123.0, 213)
        sds.array_append_safe(&ds, 3)
        _ = sds.array_slice(&ds)
        _ = sds.array_get(ds, 2)
        _ = sds.array_get_safe(ds, 3213)
        _ = sds.array_get_ptr(&ds, 2)
        _ = sds.array_get_ptr_safe(&ds, 3213)
        sds.array_set(&ds, 3, 6.2)
        sds.array_set_safe(&ds, 6, 6.3)
        _ = sds.array_has_index(ds, 9)
        _ = sds.array_pop_back(&ds)
        _ = sds.array_pop_back_safe(&ds)
    }

    {
        ds: sds.Soa_Array(123, [2]f32)
        sds.soa_array_append(&ds, 123.0)
        sds.soa_array_append_safe(&ds, 3)
        _ = sds.soa_array_slice(&ds)
        _ = sds.soa_array_get(ds, 1)
        _ = sds.soa_array_get_safe(ds, 3213)
        _ = sds.soa_array_get_ptr(&ds, 1)
        _, _ = sds.soa_array_get_ptr_safe(&ds, 3213)
        sds.soa_array_set(&ds, 0, 6.2)
        sds.soa_array_set_safe(&ds, 6, 6.3)
        _ = sds.soa_array_has_index(ds, 9)
        _ = sds.soa_array_pop_back(&ds)
        _ = sds.soa_array_pop_back_safe(&ds)
    }

    {
        ds: sds.Bit_Array(1024)
        _ = sds.bit_array_get(ds, 10)
        _ = sds.bit_array_get_safe(ds, 10)
        sds.bit_array_set_true(&ds, 4)
        sds.bit_array_set_true_safe(&ds, 2093823)
        sds.bit_array_set_false(&ds, 4)
        sds.bit_array_set_false_safe(&ds, 2093823)
        sds.bit_array_set(&ds, 4, true)
        sds.bit_array_set_safe(&ds, 2093823, true)
    }

    {
        ds: sds.Queue(1024, f32)
        sds.queue_push_back(&ds, 3)
        sds.queue_push_back_elems(&ds, 3, 6, 9)
        sds.queue_push_front(&ds, -2.3)
        _ = sds.queue_get(ds, 3)
        _ = sds.queue_get_safe(ds, 3)
        _ = sds.queue_get_ptr(&ds, 9)
        _ = sds.queue_get_ptr_safe(&ds, 9)
        _ = sds.queue_peek_back(&ds)
        _ = sds.queue_peek_back_safe(&ds)
        _ = sds.queue_peek_front(&ds)
        _ = sds.queue_pop_back(&ds)
        _ = sds.queue_pop_back_safe(&ds)
        _ = sds.queue_pop_front(&ds)
        _ = sds.queue_pop_front_safe(&ds)
    }

    {
        Handle :: sds.Handle(u16, u16)
        ds: sds.Pool(1024, f32, Handle)
        sds.pool_clear(&ds)
        first := sds.pool_append(&ds, 1.234)
        _ = sds.pool_get(ds, first)
        _ = sds.pool_get_ptr(&ds, first)
        _ = sds.pool_get_safe(ds, Handle{823, 92})
        _ = sds.pool_get_ptr_safe(&ds, Handle{823, 92})
        sds.pool_set(&ds, first, 123.3)
        sds.pool_set_safe(&ds, Handle{323, 2}, -123.3)
        _ = sds.pool_has_handle(ds, first)
        _ = sds.pool_has_index(ds, first.index)
        _ = sds.pool_index_is_valid(ds, 10)
        _, _, _ = sds.pool_index_get_ptr_safe(&ds, 3)
        _, _, _ = sds.pool_index_get_safe(ds, 3)
        sds.pool_remove(&ds, first)
    }

    {
        Handle :: sds.Handle(u16, u16)
        ds: sds.Indirect_Array(1024, f32, Handle)
        first := sds.indirect_array_append(&ds, 1.23)
        _ = sds.indirect_array_slice(&ds)
        sds.indirect_array_set(&ds, first, 10)
        sds.indirect_array_set_safe(&ds, Handle{}, 120)
        _ = sds.indirect_array_get(ds, first)
        _ = sds.indirect_array_get_safe(ds, Handle{})
        _ = sds.indirect_array_get_ptr(&ds, first)
        _ = sds.indirect_array_get_ptr_safe(&ds, Handle{})
        assert(sds.indirect_array_has_handle(ds, first))
        assert(sds.indirect_array_has_index(ds, 0))
        sds.indirect_array_remove(&ds, first)
    }

    fmt.println("Done!")
}