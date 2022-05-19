local ok, feline = pcall(require, "feline")

if not ok then
  return
end

feline.setup {
  preset = "noicon"
}
