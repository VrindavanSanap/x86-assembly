
;
; MACROS
;


;;;
;;;  write a message to stdout
;;;
;;;  MSG_WRITE  buffer count
;;;  


%macro MSG_WRITE 2
	mov	rdi,1
	mov	rsi,%1
	mov	rdx,%2
	mov	rax,1		; write message to stdout
	syscall
%endmacro


;
; Code
;

	global	_start
	section	.text

;;;
;;;  _start
;;;

_start:
	MSG_WRITE explanation,explanation_size

	;
	; display memory segment information before we create a heap
	;
	MSG_WRITE msg_before,msg_before_size
	call	print_self_map

	;
	; call brk(2) to receive the lower address for the heap
	;	
	;  int brk(void *addr);
	;
	mov	rdi,0
	mov	rax,12		; brk(2)
	syscall

	;
	; The start of the new heap is in rax; let's save it in r14
	;	
	mov	r14,rax

	MSG_WRITE msg_after,msg_after_size

	call print_self_map

	;
	; Now let's increase the size and call brk(2) again
	;
	;  int brk(void *addr);

	add	r14,4096
	mov	rdi,r14
	mov	rax,12		; brk(2)
	syscall
	
	MSG_WRITE msg_finally,msg_finally_size

	call print_self_map


	MSG_WRITE msg_before_file_mmap,msg_before_file_mmap_size

	;
	; Now let's create a file-backed dynamic mmap segment
	; 

	;
	; int stat(const char *path, struct stat *buf);
	;
	mov	rdi,etc_hosts
	mov	rsi,stat
	mov	rax,4		; stat(2)
	syscall
	mov	qword r13,[stat_size] ; save the size in r13

	;
	; int open(file,permission)
	;
	mov	rdi,etc_hosts	; pathname
	mov	rsi,0		; flags
	mov	rdx,0		; mode
	mov	rax,2		; open(2)
	syscall

	;
	;   void *mmap(void *addr, size_t length, int prot, int flags,
        ;         int fd, off_t offset);

	mov	rdi,0	  	; addr; a zero value indicates we don't care where in memory this is located
	mov	rsi,r13		; size_t; how many bytes we want in the mapping
	mov	rdx,1		; prot; access permissions; let's go with rw- = PROT_READ = 0x1
		  		; (viz., /usr/include/asm-generic/mman-common.h)
	mov	r10,0x02	; flags; MAP_PRIVATE = 0x02 = 0x02 would be good choices
		  		; (viz., /usr/include/asm-generic/mman-common.h)
	mov	r8,rax		; fd, value from previous open
	mov	r9,0		; offset
	mov	rax,9		; mmap(2)
	syscall

	; let's now save the address of the buffer in r12, and we will print this out after
	; our other message
	mov	r12,rax

	call print_self_map

	MSG_WRITE msg_here_are_contents_of_our_mapfile,msg_here_are_contents_of_our_mapfile_size

	;
	; ssize_t write(int fd, const void *buf, size_t count)
	;

	mov	rdi,1		; fd
	mov	rsi,r12		; where the memory mapping starts
	mov	rdx,r13		; how many bytes
	mov	rax,1		; write(2)
	syscall

	MSG_WRITE msg_before_anon_mmap,msg_before_anon_mmap_size

	;
	; Now let's create an anonymous dynamic mmap segment
	; 
	;   void *mmap(void *addr, size_t length, int prot, int flags,
        ;         int fd, off_t offset);

	mov	rdi,0	  	; addr; a zero value indicates we don't care where in memory this is located
	mov	rsi,4096	; size_t; how many bytes we want in the mapping
	mov	rdx,3		; prot; access permissions; let's go with rw- = PROT_READ|PROT_WRITE = 0x3
		  		; (viz., /usr/include/asm-generic/mman-common.h)
	mov	r10,0x22	; flags; MAP_ANONYMOUS|MAP_PRIVATE = 0x20|0x02 = 0x22 would be good choices
		  		; (viz., /usr/include/asm-generic/mman-common.h)
	mov	r8,-1		; fd; nonce value for an anonymous mapping
	mov	r9,0		; offset; nonce value for an anonymous mapping
	mov	rax,9		; mmap(2)
	syscall

	call print_self_map


	; exit(result)

	mov	rdi,0		; 
	mov	rax,60		; exit(2)
	syscall


;
; Routines
;

print_self_map:

	; int open(pathname, flags, mode)
	mov	rdi,proc_self	; pathname
	mov	rsi,0		; flags
	;
	; (viz., /usr/include/asm-generic/fcntl.h:#define O_RDONLY	00000000)
	;
	mov	rdx,0		; mode
	mov	rax,2		; open(2)
	syscall

	;
	;  At this point, rax now has the file descriptor (or error... ;-) for the file.
	;	
	;  Let's save it in r15 for later
	;
	mov	r15,rax

	; ssize_t read(int fd, void *buf, size_t count)
	mov	rdi,rax	        ; fd
	mov	rsi,buffer	; buffer
	mov	rdx,buffer_size ; count
	mov	rax,0		; read(2)
	syscall

	;
	; At this point, rax now has the number of bytes that were successfully read from the file descriptor
	;	
	;
	;   ssize_t write(int fd, const void *buf, size_t count)
	;
	mov	rdi,1	    	; writing to stdout, fd=1
	mov	rsi,buffer	; buffer
	mov	rdx,rax		; just the number of bytes read
	mov	rax,1		; write(2)
	syscall

	;
	;  close(fd)
	;
	mov	rdi,r15		; recover fd from r15
	mov	rax,3		; close(2)
	syscall

	ret

;
; read-only data
;

proc_self: db "/proc/self/maps",0

etc_hosts: db "/etc/hosts",0

explanation:  
	db 10,10,"*** CNT5605: Learning about the Linux x86_64 execution environment",10
	db "***",10
	db "*** This program demonstrates how various bits of the Linux x86_64",10
	db "*** environment are created as the result of either the kernel",10
	db "*** acting on the initialization information contained in ELF64",10
	db "*** headers, or are created by subsequent system calls.",10
	db 10
explanation_size equ $ - explanation

msg_before: 
	db 10,"*** Let's demonstrate the creation of a heap. Here are the contents",10
	db "*** of our /proc/self/maps before we begin the steps in creating a heap:",10,10
msg_before_size equ $ - msg_before

msg_after:
	db 10,"*** First, let's execute brk(2), passing in an address of 0, and look",10
	db "*** at the '/proc/self/maps' again to see if there are any changes:",10,10
msg_after_size equ $ - msg_after

msg_finally:
	db 10,"*** No, there weren't. So let's execute brk a second time, after adding 4096 to the",10
	db "*** address returned by the first brk. Now the maps show",10
	db "*** a new memory segment labelled [heap]:",10,10
msg_finally_size equ $ - msg_finally


msg_before_file_mmap:
	db 10,"*** Next, we will create another dynamic segment. We can",10
        db "*** only have one heap, but we can create more dynamic",10
	db "*** segments with the mmap(2) system call.",10
	db "***",10
	db "*** First, let's call mmap(2) to create a file-backed (/etc/hosts) memory segment on the fly:",10,10
msg_before_file_mmap_size equ $ - msg_before_file_mmap

msg_here_are_contents_of_our_mapfile:
	db 10,"*** And here are the contents of the file /etc/hosts mapped into memory.",10
	db "*** There's no explicit read(2) being done here; I am just sending the contents",10
	db "*** of the mapped-in memory to file descriptor 1 (stdout):",10,10
msg_here_are_contents_of_our_mapfile_size equ $ - msg_here_are_contents_of_our_mapfile	

msg_before_anon_mmap:
	db 10,"*** Now let's make the second memory mapping an anonymous one, with no file backing",10
	db "*** it.",10,10
msg_before_anon_mmap_size equ $ - msg_before_anon_mmap

;
; volatile (writable) data
;

	   section .data

stat:
stat_dev_t:	times 8 db 0	; dev_t st_dev, ID of device containing file 
stat_ino_t:	times 8 db 0	; ino_t st_ino, inode number
stat_mode_t:	times 4 db 0	; mode_t st_mode, permission
stat_nlink:	times 4 db 0	; nlink_t st_nlink, number of hard links
stat_uid:	times 4 db 0	; uid_t st_uid, user id of owner
stat_gid:	times 4 db 0	; gid_t st_gid, group id of owner
stat_rdev: 	times 8 db 0	; dev_t st_rdev, device id (if special file)
stat_pad1:	times 8 db 0	; PADDING
stat_size:	times 8 db 0	; off_t st_size, size of file in bytes
stat_blksize:	times 4 db 0	; blksize_t st_blksize, blocksize filesystem i/o
stat_pad2:	times 4 db 0	; MORE PADDING
stat_blocks:	times 8 db 0	; blkcnt_t st_blocks, number of 512byte blocks ?
stat_atime:	times 8 db 0	; time_t st_atime, time of last access
stat_atime_nsec: times 8 db 0	; something to do with nsec (nanosec?)
stat_mtime:	times 8 db 0	; time_t st_mtime, time of last modification
stat_mtime_nsec: times 8 db 0	; something to do with nsec (nanosec?)
stat_ctime:	times 8 db 0	; time_t st_ctime, time of last status change
stat_ctime_nsec: times 8 db 0	; something to do with nsec (nanosec?)
stat_unused4:	times 4 db 0	; unused?
stat_unused5:	times 4 db 0	; unused?
stat_dunno:	times 16 db 0	; when I sizeof(struct stat), it comes to 144 bytes, not 128

buffer: times 4096 db 0
buffer_size equ $ - buffer
