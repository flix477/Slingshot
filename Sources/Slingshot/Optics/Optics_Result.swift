// no complicated lenses for this one, much easier to just use optional chaining
// like result.success?.property result.failure?.property
public extension Result {
    var success: Success? {
        switch self {
        case .success(let success):
            return success
        case .failure:
            return nil
        }
    }
    
    var failure: Failure? {
        switch self {
        case .success:
            return nil
        case .failure(let failure):
            return failure
        }
    }
}
