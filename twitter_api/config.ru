require 'rubygems'
require 'rack'
#use ActiveRecord::ConnectionAdapters::ConnectionManagement
require_relative './twitter'
run Twitter::API