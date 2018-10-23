flag(flag, value)
---
flag(:error_handler, module()) :: module()
flag(:max_heap_size, heap_size()) :: heap_size()
flag(:message_queue_data, :erlang.message_queue_data()) :: 
       :erlang.message_queue_data()
flag(:min_bin_vheap_size, non_neg_integer()) :: non_neg_integer()
flag(:min_heap_size, 
