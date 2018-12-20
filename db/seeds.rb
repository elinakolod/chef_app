# frozen_string_literal: true

require 'ffaker'

Project.delete_all

project = Project.create!(
  name: FFaker::Lorem.sentence,
  descr: FFaker::Lorem.paragraph
)
