from django.contrib import admin
from .models import Listing

class ListingAdmin(admin.ModelAdmin):
    list_display = ('id', 'title', 'is_published', 'price', 'list_date', 'realtor') # show this element lists/tuple as column in the admin table
    list_display_links = ('id', 'title') # make the column data liked to the object page
    list_filter = ('realtor',) # add filter. for one item, must use comma at the end, otherwise will get error
    list_editable = ('is_published',) #set certail column to be editable without going to the object page
    search_fields = ('title', 'description', 'address', 'city', 'state', 'zipcode', 'price') # add search cell and inlcude which data to be the search sources
    list_per_page = 25 # define the row data per page

admin.site.register(Listing, ListingAdmin)