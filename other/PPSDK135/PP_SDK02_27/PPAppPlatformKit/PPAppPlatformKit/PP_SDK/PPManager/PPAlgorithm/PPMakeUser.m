//
//  PPMakeUser.m
//  SDKDemoForFramework
//
//  Created by Seven on 13-7-3.
//  Copyright (c) 2013年 Server. All rights reserved.
//

#import "PPMakeUser.h"

//void Encode32_PP(uint64_t num, char * out_str)
//{
//	char * d = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
//	
//	int pos = 0;
//	
//	bool start = false;
//	
//	for(int i=13; i>=0; i--)
//	{
//		int temp = num / pow(32, i);
//		
//		if(start || temp > 0 || i==0)
//		{
//			out_str[pos ++] = d[temp];
//			num -= temp * pow(32, i);
//			start = true;
//		}
//	}
//	
//	out_str[pos] = '\0';
//}
//
//void MakeUserName(uint64_t ecid, char * uuid, char * mac, char * out_username/*16 bytes buffer*/)
//{
//	char * d = "23456789ABCDEFGHJKLMNPQRSTUVWXYZ";
//	
//	unsigned char uuid_magic_num = 0;
//	while(*uuid != '\0')
//	{
//		uuid_magic_num += *uuid;
//		uuid ++;
//	}
//	
//	unsigned char mac_magic_num = 0;
//	while(*mac != '\0')
//	{
//		mac_magic_num += *mac;
//		mac ++;
//	}
//	
//	uint64_t temp = (ecid << 16) | (((uint32_t)uuid_magic_num) << 8) | mac_magic_num;
//	
//	*out_username = 'P';
//	Encode32_PP(temp, out_username + 1);
//	int check_sum = 0x5B;
//	char *temp_str = out_username;
//	while(*temp_str != '\0')
//	{
//		check_sum += (unsigned char)*temp_str;
//		temp_str ++;
//	}
//	
//	int temp_len = strlen(out_username);
//	out_username[temp_len] = d[check_sum % 32];
//	out_username[temp_len + 1] = '\0';
//}
//
//void MakePassword(uint64_t ecid, char * uuid, char * mac, char * out_password/*16 bytes buffer*/)
//{
//	uint16_t uuid_magic_num = 0x5FB7;
//	while(*uuid != '\0')
//	{
//		uuid_magic_num ^= ((*uuid) * 0x101);
//		uuid ++;
//	}
//	
//	uint16_t mac_magic_num = 0xB8E6;
//	while(*mac != '\0')
//	{
//		mac_magic_num ^= ((*mac) * 0x101);
//		mac ++;
//	}
//	
//	uint64_t temp = (ecid << 16) | (((uint32_t)uuid_magic_num) << 16) | mac_magic_num;
//	
//	Encode32_PP(temp, out_password);
//    
//}

