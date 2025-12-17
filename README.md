# Mikrotik-Demo-Config
This is my mikrotik configuration for small business upto 40-60 Devices per-day. Mostly user online meeting

🌐 Mikrotik RouterOS Configuration Analysis (RB2011UiAS)

Project Overview

This repository contains a sanitized configuration export (new-config.rsc) for a Mikrotik RB2011UiAS router, demonstrating the setup and administration skills required to manage a modern, multi-device corporate or small-to-medium office network.

The configuration highlights specific expertise in Network Segmentation, Quality of Service (QoS), and Layer 3 Security.

🎯 Architectural Highlights Demonstrated

The setup reflects a structured network design focused on reliability and traffic control:

##Component :
Interface Naming

##Configuration Detail :
Ethernet ports are clearly labeled (e.g., ether1_Biznet, ether2_DecoS7, ether3_AX10_1stFloor) rather than generic names.

##Skill Demonstrated :
Professional Documentation & Administration

##Component :
Network Segmentation

##Configuration Detail :
Uses one main bridge (theBridge) for internal LAN (192.168.10.0/24) connected to various access points (DecoS7, AX10, Ax20), and a separate network on ether5 (192.168.13.0/24) for specialized use.

##Skill Demonstrated :
Network Architecture & Logical Separation

##Component :
Quality of Service (QoS)

##Configuration Detail :
Implementation of a Queue Tree using fq-codel and theCake queue types, with a defined total bandwidth limit (max-limit=250M) and traffic prioritization (Balancer).

##Skill Demonstrated :
Traffic Management, Bandwidth Control, & Performance Tuning

##Component :
Security (Firewall Filter)

##Configuration Detail :
Strict Layer 3 filtering: explicitly drops invalid and untracked connections, drops all incoming traffic from WAN unless explicitly allowed or destined for a NAT rule, and allows access only from defined LAN address lists.

##Skill Demonstrated :
Network Security, ACL Management, & Threat Prevention

##Component :
DNS Management

##Configuration Detail :
Implementation of DNS redirection (NAT Rules) forcing all LAN traffic on port 53 to use the router's DNS (1.1.1.1, 8.8.8.8).

##Skill Demonstrated :
Security Enforcement & Internal Traffic Control

##Component :
System Hygiene

##Configuration Detail :
Disabling unused services (FTP, Telnet, WWW, API) and interfaces (ether6 through sfp1).

##Skill Demonstrated :
Security Hardening & Best Practice Administration

⚙️ Key Configuration Areas (References in new-config.rsc)

/interface ethernet: Clear port labeling and disabling of unused interfaces.

/ip firewall filter and /ip firewall address-list: Defining allowed_to_router lists and implementing strict chain input and forward drop rules.

/ip firewall nat: Using masquerade for WAN and redirect rules for DNS forcing.

/queue tree and /queue type: Implementation of complex traffic shaping rules using modern queuing disciplines (theCodel, theCake).

/system scheduler: Scheduled system reboot (Daily-Reboot) showing proactive maintenance planning.

⚠️ Note on Confidentiality

This configuration file has been fully sanitized. All sensitive data, including public IP addresses, MAC addresses, and proprietary comments, have been removed or replaced with generic placeholders to protect company confidentiality.

This analysis demonstrates applied expertise in Mikrotik RouterOS, complementing the CCNA skills listed on my resume.
