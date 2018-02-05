 mtrace testmtrace

gdb bin/watch_dog
run
bt


因为c++的强类型转换，所以参数是指针时，不能转入整数（会导致数值是随机数）
另外创建线程的时间内，指针指向的内容改变，导致并发线程参数内容相同，所以要提前分配新地址空间存入参数。
		sockfd = accept(sockfd_server, (struct sockaddr*) (&s_addr_client),
				(socklen_t *) (&client_length));
		if (sockfd == -1) {
			log_error_print(g_debug_verbose, "Accept error!");
			//ignore current socket ,continue while loop.
			continue;
		}
		log_info_print(g_debug_verbose, "A new connection occurs![%d]", sockfd);
		int * p = (int *) malloc (sizeof(int));
		memcpy(p, &sockfd, sizeof(int));
		if (pthread_create(&thread_id, &attr, thread_business_handle, (void *) (p)) != 0) {
			log_error_print(g_debug_verbose, "pthread_create error!");
			//break while loop
			break;
		}
		pthread_detach(thread_id);


cat /proc/net/sockstat
cat /etc/sysctl.conf

netstat -lanpt|grep app|wc
