#include <linux/kernel.h>
#include <linux/version.h>
#include <linux/init.h>
#include <linux/syscalls.h>
#include <linux/tcp.h>
#include "../include/config.h"

static int __init ohayo(void){
#ifdef DEBUG
	printk(KERN_INFO "OwO :: rootkit loaded\n");
#endif

}

static void __exit sayonara(void) {
#ifdef DEBUG
	printk(KERN_INFO "UwU :: bye!!\n");
#endif
}

module_init(ohayo);
module_exit(sayonara);
