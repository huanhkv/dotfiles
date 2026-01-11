#include <mach/mach.h>
#include <unistd.h>
#include <stdio.h>

struct memory {
  mach_port_t host;
  vm_size_t page_size;
  uint64_t total;
  uint64_t free;
  uint64_t used;
  int used_percent;
};

static inline void memory_init(struct memory* mem) {
  mem->host = mach_host_self();
  mach_msg_type_number_t count = HOST_VM_INFO64_COUNT;
  vm_statistics64_data_t vm_stat;
  host_page_size(mem->host, &mem->page_size);
  host_statistics64(mem->host, HOST_VM_INFO64, (host_info64_t)&vm_stat, &count);
  mem->total = (vm_stat.wire_count + vm_stat.active_count + vm_stat.inactive_count + vm_stat.free_count) * mem->page_size;
}

static inline void memory_update(struct memory* mem) {
  mach_msg_type_number_t count = HOST_VM_INFO64_COUNT;
  vm_statistics64_data_t vm_stat;
  host_statistics64(mem->host, HOST_VM_INFO64, (host_info64_t)&vm_stat, &count);
  mem->free = vm_stat.free_count * mem->page_size;
  mem->used = (vm_stat.wire_count + vm_stat.active_count + vm_stat.inactive_count) * mem->page_size;
  mem->used_percent = (int)((double)mem->used / (double)(mem->used + mem->free) * 100.0);
} 