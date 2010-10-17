# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{farmingengineers}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Matt Burke"]
  s.date = %q{2010-10-16}
  s.description = %q{Invoice generators, etc.}
  s.email = %q{mr.matt.burke@gmail.com}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "Gemfile",
     "Gemfile.lock",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "invoice.rb",
     "lib/egg_csa_invoice.rb",
     "lib/farming_engineers.rb",
     "lib/farming_engineers/invoices.rb",
     "lib/farming_engineers/invoices/.eggs.rb.swp",
     "lib/farming_engineers/invoices/common.rb",
     "lib/farming_engineers/invoices/eggs.rb",
     "lib/instance_eval_attr.rb",
     "spec/egg_csa_invoices.rb",
     "spec/spec.opts",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/spraints/farmingengineers}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{Stuff that's useful to the farming engineers.}
  s.test_files = [
    "spec/egg_csa_invoices.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<yard>, [">= 0"])
      s.add_runtime_dependency(%q<ruport>, ["> 1.6.3"])
      s.add_runtime_dependency(%q<ruport-util>, ["> 0.14.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<yard>, [">= 0"])
      s.add_dependency(%q<ruport>, ["> 1.6.3"])
      s.add_dependency(%q<ruport-util>, ["> 0.14.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<yard>, [">= 0"])
    s.add_dependency(%q<ruport>, ["> 1.6.3"])
    s.add_dependency(%q<ruport-util>, ["> 0.14.0"])
  end
end

