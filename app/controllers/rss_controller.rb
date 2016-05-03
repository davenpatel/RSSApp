require 'rss'
require 'json'

class RssController < ApplicationController
  def index
    load_site_feed
    load_rss_feed
  end

  def save_rss_feed
    data = JSON.parse(params["data"])
    if RssFeed.where(link: data["link"]).any?
      flash[:danger] = "You've already saved this link"
    else
      RssFeed.create(data)
      flash[:success] = "RSS link saved successfully"
    end
    redirect_to root_path
  end

  def remove_rss_feed
    if RssFeed.delete(params[:id])
      flash[:success] = "Saved link removed successfully"
    else
      flash[:danger] = "Error encountered when trying to remove link"
    end
    redirect_to root_path
  end

private
  def load_site_feed
    @site_feed = []
    url = 'http://feeds.arstechnica.com/arstechnica/index.rss'
    open(url) do |rss|
      feed = RSS::Parser.parse(rss)
      @feed_title = feed.channel.title
      feed.items.each do |item|
        @site_feed << {title: item.title, link: item.link, description: item.description}
      end
    end
  end

  def load_rss_feed
    @rss_feeds = RssFeed.all
  end
end