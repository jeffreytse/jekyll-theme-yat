---
layout: post
title: Skill Building 01 - Setting Up Shop with a Website
subtitle: A quick little writeup of how this website was made 
excerpt_image: "/assets/images/jekyll-og.png"
categories: jekyll
tags: [jekyll, netlify, tech, web]
---

## Introduction

My first foray into learning some new skills this year was, of course, building this website! I didn’t think to keep notes on this as I worked (oops, learning) but I’ll try to explain as much of the process as I can.

## Jekyll

The first component of this website is Jekyll. This is my first time using Jekyll, or really any Ruby at all, but it’s been quite simple to use once I got familiar with it. Jekyll is a static site generator written in Ruby that essentially takes your plain text of whatever format you choose and builds it into a site ready to be served. Jekyll has a [great step-by-step guide for building a site from scratch](https://jekyllrb.com/docs/step-by-step/01-setup/) that was really helpful for someone like me just getting started. 

Once I worked through most of that tutorial and looked around online at websites other people were building using Jekyll, I realized I really wanted a nice theme for the site. I found [this beautiful theme by Jeffrey Tse](https://github.com/jeffreytse/jekyll-theme-yat), and used that as the basis for the site. Big thank you to the open source contributors out there! I hope to join your ranks soon. 

## Netlify CMS

The next piece of this puzzle was hosting and serving the site. Using Netlify CMS, I can host my website files on my own GitHub and Netlify will deploy them for me to my own custom domain. Perfect! Most of this setup was pretty easy. All I had to do was create an account and let it know which repository I wanted it to use, get those permissions set up on GitHub, and my site is now deployed onto a Netlify subdomain.

Of course, I wanted the site on *my* domain, which took a little bit of tinkering for me. I had purchased my domain via Squarespace, so I had to configure my domain’s DNS settings to get the pieces connected. Netlify has documentation on how to do this, but the instructions you find on the ‘domain management’ page I found didn’t work for me. It had me set it up like so:

>an A record pointing the bare domain (yoursite.com) to Netlify’s load balancer IP address

>a CNAME record pointing ‘www’ to the site’s Netlify subdomain

I found *for me*, this did not work and Netlify wasn’t able to provision me a TLS certificate. More snooping around online found me the way it *should* be configured:

>an A record with ‘@’ in the host field pointing to Netlify’s load balancer IP address

>a CNAME record pointing ‘www’ to the site’s Netlify subdomain (no change here)

And that fixed it up! I only write this because it took me longer than I expected to find the solution that worked for me in my exact situation. And of course, now that I know the solution, I found it in the [Netlify documentation](https://docs.netlify.com/domains-https/custom-domains/). 🤦 I’m sure someone with more experience with these kinds of things would have had this solved in a second, but hey, I’m learning and that’s why I’m here in the first place. 

## Conclusion

That’s basically it! After replacing template text and images the site is ready to go. This is by no means a comprehensive guide but I hope I’ve provided some resources that would help someone wanting to build their own site. This was a new method of constructing a website for me, and I found it to be pretty lightweight, fast, and easy to figure out! 
