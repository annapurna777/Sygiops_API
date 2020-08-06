# load all core_ext extensions
Dir.glob( Rails.root.join('engines/sygiops_support/lib/sygiops_support/core_ext/**/*') ).sort.each do |file|
  if File.file?(file)
    require file
  end
end
Dir.glob( Rails.root.join('engines/sygiops_support/lib/sygiops_support/mixin/**/*') ).sort.each do |file|
  if File.file?(file)
    require file
  end
end
