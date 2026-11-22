package bean;

public class Suggestion {
    protected int suggestionID;
    protected String suggestionTitle;
    protected String suggestionContent;
    protected String submitTime;

    public int getSuggestionID() {
        return suggestionID;
    }

    public void setSuggestionID(int suggestionID) {
        this.suggestionID = suggestionID;
    }

    public String getSuggestionTitle() {
        return suggestionTitle;
    }

    public void setSuggestionTitle(String suggestionTitle) {
        this.suggestionTitle = suggestionTitle;
    }

    public String getSuggestionContent() {
        return suggestionContent;
    }

    public void setSuggestionContent(String suggestionContent) {
        this.suggestionContent = suggestionContent;
    }

    public String getSubmitTime() {
        return submitTime;
    }

    public void setSubmitTime(String submitTime) {
        this.submitTime = submitTime;
    }
}